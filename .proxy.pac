function FindProxyForURL(url, host){
  if (dnsDomainIs(host, "remote.example.com")
      || shExpMatch(host, "192.168.001.*")
      || shExpMatch(host, "octopress.192.168.*")
     ){
    return "SOCKS5 localhost:10080; DIRECT";
  }
  return "SOCKS5 localhost:10080; DIRECT";
}
