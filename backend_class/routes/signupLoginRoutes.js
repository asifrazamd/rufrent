const express = require('express');
const AuthController = require('../controllers/signupLogin');
const router = express.Router();

const authController = new AuthController();

router.post('/signup', (req, res) => authController.signup(req, res));
router.post('/login', (req, res) => authController.login(req, res));

module.exports = router;
