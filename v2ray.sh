#!/bin/sh

# config v2ray
cat << EOF > /usr/bin/v2ray/config.json
{		
    "inbounds": 		
    [		
        {		
            "port": $PORT,"protocol": "vmess",		
            "settings": {"clients": [{"id": "$UUID"}]},		
            "streamSettings": {"network": "ws"}		
        }		
    ],		
    "outbounds": 		
    [		
        {"protocol": "freedom"},		
        {"protocol": "blackhole","tag": "blocked"},
        {"protocol": "socks","tag": "socksTor","settings": {"servers": [{"address": "127.0.0.1","port": 9050}]}}		
    ],		
    		
    "routing": 		
    {		
        "rules": 		
        [		
            {"type": "field","outboundTag": "socksTor","domain": ["geosite:tor"]},		
            {"type": "field","outboundTag": "blocked","domain": ["geosite:category-ads-all"]}		
        ]		
    }		
}		
EOF

# start tor v2ray
nohup tor &
/usr/bin/v2ray/v2ray -config /usr/bin/v2ray/config.json
