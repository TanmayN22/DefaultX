// backend/server.js
const express = require("express");
const bodyParser = require("body-parser");
const jwt = require("jsonwebtoken");
const cors = require("cors"); // Import cors

const app = express();
const PORT = process.env.PORT || 3000;
const JWT_SECRET = process.env.JWT_SECRET || "your_super_secret_jwt_key_here"; // Use a strong, random key in production!

// Whitelisted users
const whitelistedUsers = [
  { email: "kaustubh130104@gmail.com", password: "password123" },
  { email: "piyushdas2004@gmail.com", password: "password123" },
  { email: "nayaktanmayg@gmail.com", password: "password123" },
];

// Middleware
app.use(cors()); // Enable CORS for all routes
app.use(bodyParser.json());

// --- Authentication Route ---
app.post("/api/login", (req, res) => {
  const { email, password } = req.body;

  if (!email || !password) {
    return res
      .status(400)
      .json({ message: "Email and password are required." });
  }

  // 1. Check if email ends with @gmail.com
  if (!email.endsWith("@gmail.com")) {
    return res
      .status(401)
      .json({ message: "Only @gmail.com accounts are allowed." });
  }

  // 2. Check if user is whitelisted
  const user = whitelistedUsers.find(
    (u) => u.email === email && u.password === password
  );

  if (!user) {
    return res
      .status(401)
      .json({ message: "Invalid credentials or user not whitelisted." });
  }

  // 3. Generate JWT Token
  const token = jwt.sign(
    { email: user.email, role: "user" }, // Payload
    JWT_SECRET,
    { expiresIn: "1h" } // Token expires in 1 hour
  );

  res.json({ message: "Login successful!", token });
});

// --- Protected Route Example (for demonstration) ---
// This middleware verifies the JWT token
function verifyToken(req, res, next) {
  const token = req.headers["authorization"]; // Bearer TOKEN
  if (!token) {
    return res.status(403).json({ message: "No token provided." });
  }

  // Remove "Bearer " prefix if present
  const cleanToken = token.startsWith("Bearer ") ? token.slice(7) : token;

  jwt.verify(cleanToken, JWT_SECRET, (err, decoded) => {
    if (err) {
      return res.status(401).json({ message: "Failed to authenticate token." });
    }
    req.user = decoded; // Add decoded payload to request
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
