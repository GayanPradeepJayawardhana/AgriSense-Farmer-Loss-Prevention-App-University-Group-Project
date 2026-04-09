import express from 'express';
import { chatWithAssistant, getChatHistory } from '../controllers/chatbotController.js';
import { protect } from '../middleware/authMiddleware.js';

const router = express.Router();

router.post('/', protect, chatWithAssistant);
router.get('/history', protect, getChatHistory);

export default router;