#!/bin/bash
set -e

# Use pre-downloaded Germany PBF
export PBF_URL=https://download.geofabrik.de/europe/germany-latest.osm.pbf

# Run Nominatim
/app/init.sh
exec /app/run.sh
