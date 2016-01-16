{
  function createArray(str) {
    var array = str.split(" ")
    array.pop()
    return array
  }

  function createContent(type, slot, interf, proto, src, dst, beginTs, endTs, pktCnt, maxSpeed, policy) {
  	var content = {
      attackType: type,
      slot: parseInt(slot),
      interface: createArray(interf),
      protocol: proto,
      source: createArray(src),
      destination: createArray(dst),
      beginTs: beginTs,
      endTs: endTs,
      packetCount: parseInt(pktCnt),
      maxSpeed: parseInt(maxSpeed),
      policy: policy
    }
    return content
  }
}

content
  = sp type:type ", " "slot=\"" slot:[0-9]+ "\", " interf:interf ", " "proto=\"" proto:[a-zA-Z0-9 \./\\#]+ "\", " "src=\"" src:ipPort "\", " "dst=\"" dst:ipPort "\", " "begin time=\"" beginTs:datetime "\", " "end time=\"" endTs:datetime "\", " "total packets=\"" pktCnt:[0-9]+ "\", " "max speed=\"" maxSpeed:[0-9]+ "\"\." policy:policy { return createContent(type, slot.join(""), interf, proto.join(""), src, dst, beginTs, endTs, pktCnt.join(""), maxSpeed.join(""), policy)}

type
  = "AttackType=\"" t:[a-zA-Z ]+ "\"" { return t.join("") }

interf
  = "receive interface=\"" it:[a-zA-Z0-9/ \-]+ "\"" { return it.join("") }

ipPort
  = s:[0-9\.: ]+ { return s.join("") }

dir
  = [a-z0-9()\- ]+

policy
  = p:[0-9#\.]+ [ "]* { return p.join("") }

datetime
  = d:date sp t:time { return d + " " + t }

date
  = YYYY:[0-9]+ "-" MM:[0-9]+ "-" DD:[0-9]+ { return YYYY.join("") + "-" + MM.join("") + "-" + DD.join("") }

time
  = hh:[0-9]+ ":" mm:[0-9]+ ":" ss:[0-9]+ { return hh.join("") + ":" + mm.join("") + ":" + ss.join("") }

sp
  = " "
