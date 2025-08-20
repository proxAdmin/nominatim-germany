#!/bin/bash
set -e

# Download Germany OSM PBF if not already present
if [ ! -f /nominatim/data.osm.pbf ]; then
    echo "Downloading Germany OSM extract..."
    curl -L -o /nominatim/data.osm.pbf https://download.geofabrik.de/europe/germany-latest.osm.pbf
fi

# Ensure /nominatim folder is writable
mkdir -p /nominatim/data
chown -R root:root /nominatim

# Set PBF file for Nominatim
export PBF_URL=/nominatim/data.osm.pbf

# Run Nominatim import and service
/app/init.sh
exec /app/run.sh
