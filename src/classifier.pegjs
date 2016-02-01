{
  function getHeader(headerTs, hostname, headerInfo) {
    var header = {
      localTime: headerTs.localTime,
      remoteTime: headerTs.remoteTime,
      hostname: hostname,
      tag: headerInfo.tag,
      version: headerInfo.version,
      module: headerInfo.module,
      serverity: headerInfo.serverity,
      brief: headerInfo.brief,
      type: headerInfo.type
    }
    return header
  }
}

sentence
  = hdr:header ":" cont:content { hdr.secInfo = cont; return hdr }

header
  = hts:headerTs sp hostname:[a-zA-Z0-9\-]+ sp hi:headerInfo { return getHeader(hts, hostname.join(""), hi) }

headerTs
  = lt:localTime sp rt:remoteTime { return {localTime: lt, remoteTime: rt} }

localTime
  = month:[a-zA-Z]+ sp+ day:[0-9]+ sp ts:time { var now = new Date(); return month.join("") + " " + day.join("") + " "  + now.getFullYear().toString() + " " + ts }

remoteTime
  = date:date sp time:brokenTime { return date + " " + time }

date
  = YYYY:[0-9]+ "-" MM:[0-9]+ "-" DD:[0-9]+ { return YYYY.join("") + "-" + MM.join("") + "-" + DD.join("") }

brokenTime
  = hh:[0-9]+ ": " mm:[0-9]+ ":" ss:[0-9]+ { return hh.join("") + ":" + mm.join("") + ":" + ss.join("") }

headerInfo
  = tag:"%%" version:[0-9]+ module:[a-zA-Z]+ "/" serverity:[0-9] "/" brief:[a-zA-Z]+ "(" type:[a-zA-Z] ")" { return {tag: tag, version: version.join(""), module: module.join(""), serverity: parseInt(serverity), brief: brief.join(""), type: type} }

content
  = c:.+ { return c.join("") }

time
  = hh:[0-9]+ ":" mm:[0-9]+ ":" ss:[0-9]+ { return hh.join("") + ":" + mm.join("") + ":" + ss.join("") }

sp
  = " "
