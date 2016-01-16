{
  function createContent(normalClosed, unsuccessClosed, policyRejected, routeRejected, blacklistRejected) {
  	var content = {
      normalClosed: parseInt(normalClosed),
      unsuccessClosed: parseInt(unsuccessClosed),
      policyRejected: parseInt(policyRejected),
      routeRejected: parseInt(routeRejected),
      blacklistRejected: parseInt(blacklistRejected)
    }
    return content
  }
}

content
  = [a-zA-Z ]+ ": " "Normal closed = " nor:[0-9]+ ", " "Unsuccessfully closed = " un:[0-9]+ ", " "Policy rejected = " po:[0-9]+ ", " "Route rejected = " ro:[0-9]+ ", " "Blacklist rejected = " bl:[0-9]+ "." { return createContent(nor.join(""), un.join(""), po.join(""), ro.join(""), bl.join(""))}
