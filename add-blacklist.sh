#/bin/bash
# 填 Cloudflare Email
CFEMAIL=""
# 填 Cloudflare API key
CFAPIKEY=""
# 填 Cloudflare Zones ID
ZONESID=""
# 填 Cloudflare Account ID
ACCOUNTID=""
# 填 IP 黑名单存放位置
IPS="/root/blacklist.txt"
# 循环提交 IPs 到 Cloudflare  防火墙黑名单
for IPADDR in `cat $IPS`
do
 echo "正在添加 IP：$IPADDR"
# curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONESID/firewall/access_rules/rules" \
   -H "X-Auth-Email: $CFEMAIL" \
   -H "X-Auth-Key: $CFAPIKEY" \
   -H "Content-Type: application/json" \
   --data '{"mode":"challenge","configuration":{"target":"ip_range","value":"'$IPADDR'"},"notes":""}'
done
