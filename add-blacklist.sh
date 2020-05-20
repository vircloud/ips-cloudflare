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
# API 调用每 5 分钟限制 1200
LIMIT="1200"
# 休息 5 分钟
SLEEP="300"
# 循环提交 IPs 到 Cloudflare  防火墙黑名单
I="1"
for IPADDR in `cat $IPS`
do
 if [ "$I" -lt "$LIMIT" ]
 then
   echo "正在添加第 $I 个 IP： $IPADDR"
#这是域名级屏蔽 curl -s -X POST "https://api.cloudflare.com/client/v4/zones/$ZONESID/firewall/access_rules/rules" \
#这是账户级屏蔽 curl -s -X POST "https://api.cloudflare.com/client/v4/accounts/$ACCOUNTID/firewall/access_rules/rules" \
   -H "X-Auth-Email: $CFEMAIL" \
   -H "X-Auth-Key: $CFAPIKEY" \
   -H "Content-Type: application/json" \
   --data '{"mode":"challenge","configuration":{"target":"ip_range","value":"'$IPADDR'"},"notes":""}'
   I=`expr $I + 1`
 else
  echo "到达 API 调用限制，休息 5 分钟......"
  sleep $SLEEP
  I="1"
 fi
done
