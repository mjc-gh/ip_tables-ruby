# iptables -A PREROUTING -t nat -i eth0 -p tcp
# --dport 943 -j REDIRECT --to-port 13

chain :prerouting, table: :nat, iface: :eth0 do
  jump :redirect do
    match :protocol, dport: 943, to_port: 13
  end
end
