#!/bin/bash
echo "main" > /tmp/keyd_layer

keyd listen | while IFS= read -r line; do
    # keyd listen outputs: /layer1/layer2/...
    # Strip leading slash, replace remaining slashes with spaces
    echo "$line" | sed 's|.*/||; s|^[+-]||' > /tmp/keyd_layer
done
