#wifi=$( ip addr | grep "wlp5s0" |grep -E -o "inet ([0-9]{1,3}[\.]){3}[0-9]{1,3}" |awk '{print $2 " "}' )
wifi=$(ip addr | grep "inet .* wlp5s0" |sed -n 's/\ *inet\ *\(\([0-9]\{1,3\}.\)\{3\}.[0-9]\{1,3\}\).*/\1/p')
#line=$( ip addr | grep "enp4s0" |grep -E -o "inet ([0-9]{1,3}[\.]){3}[0-9]{1,3}" |awk '{print $2 " "}' )
line=$(ip addr | grep "inet .* enp4s0" |sed -n 's/\ *inet\ *\(\([0-9]\{1,3\}.\)\{3\}.[0-9]\{1,3\}\).*/\1/p')

# when have special meaning
# sed {: \{
# sed (: \(, no matter if it's a group
# sed ?: \?
# sed [: [

if [ -n "$wifi" ]; then
echo -n "  $wifi"
fi
echo -n '|'
if [ -n "$line" ]; then
echo -n " $line"
fi
echo
