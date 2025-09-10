// backend/server.js
const express = require("express");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const cors = require("cors");
require("dotenv").config(); // <--- Add this line at the very top

const app = express();
// Now, PORT and JWT_SECRET will be loaded from process.env, which includes .env file variables
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET; // <--- REMOVE THE FALLBACK HERE! If not set, it's a critical error.

// IMPORTANT: In a real application, you should *always* ensure JWT_SECRET is set.
if (!JWT_SECRET) {
  console.error(
    "FATAL ERROR: JWT_SECRET is not defined. Please set it in your .env file or environment variables."
  );
  process.exit(1); // Exit the process if the secret is missing
}

// Whitelisted users (for demo purposes)
const whitelistedUsers = [
  { email: "kaustubh130104@gmail.com", password: "password123" },
  { email: "piyushdas2004@gmail.com", password: "password123" },
  { email: "nayaktanmayg@gmail.com", password: "password123" },
];

// Middleware
app.use(cors());
app.use(bodyParser.json());

// --- Authentication Route ---
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res
      .status(400)
      .json({ message: "Email and password are required." });
  }

  if (!email.endsWith("@gmail.com")) {
    return res
      .status(401)
      .json({ message: "Only @gmail.com accounts are allowed." });
  }

  const user = whitelistedUsers.find(
    (u) => u.email === email && u.password === password
  );

  if (!user) {
    return res
      .status(401)
      .json({ message: "Invalid credentials or user not whitelisted." });
  }

  const token = jwt.sign(
    { email: user.email, role: "user" },
    JWT_SECRET, // Using the secret from environment variable
    { expiresIn: "1h" }
  );

  res.json({ message: "Login successful!", token });
});

// --- Protected Route Example (for demonstration) ---
function verifyToken(req, res, next) {
  const token = req.headers["authorization"];
  if (!token) {
    return res.status(403).json({ message: "No token provided." });
  }

  const cleanToken = token.startsWith("Bearer ") ? token.slice(7) : token;

  jwt.verify(cleanToken, JWT_SECRET, (err, decoded) => {
    // Using the secret from environment variable
    if (err) {
      return res.status(401).json({ message: "Failed to authenticate token." });
    }
    req.user = decoded;
    next();
  });
}

app.get("/api/protected", verifyToken, (req, res) => {
  res.json({
    message: "This is a protected route!",
    user: req.user,
    data: "Sensitive data for authenticated users.",
  });
});

// Start the server
app.listen(PORT, () => {
  console.log(`Backend server running on http://localhost:${PORT}`);
});
