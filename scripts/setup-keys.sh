#!/bin/bash
# setup-keys.sh - Setup SSH and GPG keys from SOPS on a new machine
# Usage: ./setup-keys.sh

set -euo pipefail

echo "=== Setting Up SSH and GPG Keys from SOPS ==="
echo ""

# Check if SOPS is available
if ! command -v sops &> /dev/null; then
    echo "❌ Error: SOPS is not installed. Please install sops-nix first."
    exit 1
fi

# Check if age key exists
if [[ ! -f ~/.config/sops/age/keys.txt ]]; then
    echo "❌ Error: Age key not found. Please run 'just sops-setup' first."
    exit 1
fi

# Check if secrets file exists
if [[ ! -f secrets/secrets.yaml ]]; then
    echo "❌ Error: secrets/secrets.yaml not found. Please copy it from your main machine."
    exit 1
fi

echo "✅ Prerequisites check passed!"
echo ""

# Create SSH directory if it doesn't exist
mkdir -p ~/.ssh
chmod 700 ~/.ssh

# Extract SSH keys
echo "🔑 Setting up SSH keys..."

# Extract SSH private key
just sops-view | grep ssh_private_key -A 5 | tail -5 > ~/.ssh/id_ed25519
if [[ -s ~/.ssh/id_ed25519 ]]; then
    chmod 600 ~/.ssh/id_ed25519
    echo "✅ SSH private key extracted and configured"
else
    echo "❌ Failed to extract SSH private key"
    exit 1
fi

# Extract SSH public key
just sops-view | grep ssh_public_key | cut -d' ' -f2 > ~/.ssh/id_ed25519.pub
if [[ -s ~/.ssh/id_ed25519.pub ]]; then
    chmod 644 ~/.ssh/id_ed25519.pub
    echo "✅ SSH public key extracted and configured"
else
    echo "❌ Failed to extract SSH public key"
    exit 1
fi

# Extract and import GPG key
echo ""
echo "🔐 Setting up GPG key..."

# Extract GPG private key
just sops-view | grep gpg_private_key -A 10 | tail -10 > ~/gpg_key.asc
if [[ -s ~/gpg_key.asc ]]; then
    # Import GPG key
    gpg --import ~/gpg_key.asc
    rm ~/gpg_key.asc
    echo "✅ GPG private key extracted and imported"
else
    echo "❌ Failed to extract GPG private key"
    exit 1
fi

# Get GPG key ID
GPG_KEY_ID=$(gpg --list-secret-keys --keyid-format LONG | grep sec | cut -d'/' -f2 | cut -d' ' -f1)
if [[ -n "$GPG_KEY_ID" ]]; then
    echo "✅ GPG Key ID: $GPG_KEY_ID"
else
    echo "❌ Failed to get GPG key ID"
    exit 1
fi

# Configure Git
echo ""
echo "⚙️  Configuring Git..."

# Extract Git config from SSH public key (fallback if not in secrets)
GIT_EMAIL=$(just sops-view | grep ssh_public_key | cut -d' ' -f3)
GIT_NAME=$(echo "$GIT_EMAIL" | cut -d'@' -f1)

# If we have git_user_name and git_user_email in secrets, use those instead
if just sops-view | grep -q git_user_name; then
    GIT_NAME=$(just sops-view | grep git_user_name | cut -d' ' -f2 | tr -d '"')
fi

if just sops-view | grep -q git_user_email; then
    GIT_EMAIL=$(just sops-view | grep git_user_email | cut -d' ' -f2 | tr -d '"')
fi

git config --global user.name "$GIT_NAME"
git config --global user.email "$GIT_EMAIL"
git config --global user.signingkey "$GPG_KEY_ID"
git config --global commit.gpgsign true

echo "✅ Git configured with:"
echo "   Name: $GIT_NAME"
echo "   Email: $GIT_EMAIL"
echo "   Signing Key: $GPG_KEY_ID"

# Start SSH agent and add key
echo ""
echo "🚀 Starting SSH agent..."
if eval "$(ssh-agent -s)" 2>/dev/null; then
    ssh-add ~/.ssh/id_ed25519
    echo "✅ SSH agent started and key added"
else
    echo "⚠️  Warning: Could not start SSH agent"
fi

# Test SSH connection (optional)
echo ""
echo "🧪 Testing SSH connection to GitHub..."
if ssh -T git@github.com -o ConnectTimeout=5 2>&1 | grep -q "successfully authenticated"; then
    echo "✅ SSH connection to GitHub successful!"
else
    echo "⚠️  Warning: SSH connection test failed. You may need to add the key to your GitHub account."
fi

# Show GPG public key
echo ""
echo "🔑 GPG Public Key (add this to GitHub):"
echo "========================================"
gpg --armor --export "$GPG_KEY_ID"
echo "========================================"

echo ""
echo "🎉 Setup Complete!"
echo ""
echo "Next steps:"
echo "1. Add the GPG public key above to your GitHub account"
echo "2. Test SSH: ssh -T git@github.com"
echo "3. Test GPG: echo 'test' | gpg --clearsign"
echo "4. Test signed commit: git commit --allow-empty -m 'Test signed commit'"
echo ""
echo "Your keys are now ready to use! 🔑✨"