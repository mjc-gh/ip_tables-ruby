chain :in, default: :drop do
  accept src: '192.168.1.0/24', dst: :any do
    match :tcp, dport: [22, 80, 443]
    match :udp, dport: 53
  end
end

chain :out, default: :accept
chain :forward, default: :drop

