{
  function createContent(proto, sip, sport, dip, dport, logTs, link, dir, policy) {
  	var content = {
      protocol: proto,
      sourceIP: sip,
      sourcePort: sport,
      destIP: dip,
      destPort: dport,
      ts: logTs,
      commLink: link,
      direction: dir,
      policy: policy
    }
    return content
  }
}

content
  = sp protocol:protocol sp "source-ip=" sip:ip ","sp "source-port=" sport:port ","sp "destination-ip=" dip:ip ","sp "destination-port=" dport:port ","sp "time=" logDate:date2 sp logTime:time ","sp link:link sp dir:dir ","sp policy:policy { var logTs = logDate + " " + logTime; return createContent(protocol, sip, sport, dip, dport, logTs, link.join(""), dir.join(""), policy.join("")) }

protocol
  = "protocol=" p:[0-9]+ "," { return parseInt(p.join("")) }

ip
  = ip1:[0-9]+ "." ip2:[0-9]+ "." ip3:[0-9]+ "." ip4:[0-9]+ { return ip1.join("") + "." + ip2.join("") + "." + ip3.join("") + "." + ip4.join("") }

port
  = p:[0-9]+ { return parseInt(p.join(""))}

link
  = [a-z0-9()\-]+
dir
  = [a-zA-Z0-9]+

policy
  = "policy=" p:[0-9#\.]+ { return p }

date2
  = YYYY:[0-9]+ "/" MM:[0-9]+ "/" DD:[0-9]+ { return YYYY.join("") + "-" + MM.join("") + "-" + DD.join("") }

time
  = hh:[0-9]+ ":" mm:[0-9]+ ":" ss:[0-9]+ { return hh.join("") + ":" + mm.join("") + ":" + ss.join("") }

sp
  = " "
