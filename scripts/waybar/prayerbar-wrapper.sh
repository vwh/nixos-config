#!/usr/bin/env bash
set -e

# This script runs prayerbar and transforms its 24-hour times to 12-hour format.

PRAYERBAR_BIN="$HOME/.nix-profile/bin/prayerbar"
JQ_BIN="$HOME/.nix-profile/bin/jq"

"${PRAYERBAR_BIN}" --city Amman --country JO --method 4 | \
"${JQ_BIN}" -c 'def convert_to_12h(time_24h):
    (time_24h | strptime("%H:%M") | strftime("%I:%M %p"));

  .text |= (
    capture("^(?<prefix>.*)(?<time>[0-9]{2}:[0-9]{2})(?<suffix>.*)$") |
    .prefix + (convert_to_12h(.time)) + .suffix
  )
  | .tooltip |= (
    split("\n") |
    map(
      if test("at [0-9]{2}:[0-9]{2}") then
        capture("^(?<prefix>.*at )(?<time>[0-9]{2}:[0-9]{2})(?<suffix>.*)$") |
        .prefix + (convert_to_12h(.time)) + .suffix
      else
        .
      end
    ) |
    join("\n")
  )
'