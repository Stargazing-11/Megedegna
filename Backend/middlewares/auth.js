const jwt = require("jsonwebtoken");

function auth(req, res, next) {
  const token = req.header("x-auth-token");
  if (!token) res.status(401).send("Access denied. No token Provided");

  try {
    const decoded = jwt.verify(token, process.env.JWTPRIVATEKEY);
    req.user = decoded._id;
    req.curr_role = decoded.role;
    next();
  } catch (ex) {
    res.status(400).send("Invalid token.");
  }
}
export default auth;
