import asyncHandler from 'express-async-handler';
import { askGemini } from '../utils/geminiClient.js';
import ChatMessage from '../models/ChatMessage.js';

// @desc    Send message to AI assistant
// @route   POST /api/chatbot
// @access  Private
export const chatWithAssistant = asyncHandler(async (req, res) => {
  const { message } = req.body;
  if (!message) {
    res.status(400);
    throw new Error('Message is required');
  }

  const user = req.user;
  let context = '';
  if (user.farmLocations && user.farmLocations.length > 0) {
    const farm = user.farmLocations[0];
    context = `Farmer has a farm named "${farm.name}" at coordinates (${farm.coordinates.lat}, ${farm.coordinates.lng}). Crop stage: ${farm.cropStage || 'unknown'}.`;
  }

  try {
    const aiResponse = await askGemini(message, context);
    await ChatMessage.create({
      userId: user._id,
      message,
      response: aiResponse,
    });
    res.json({ response: aiResponse });
  } catch (error) {
    console.error('Chatbot Error:', error);
    res.status(500);
    throw new Error(`AI service error: ${error.message}`);
  }
});

// @desc    Get chat history for current user
// @route   GET /api/chatbot/history
// @access  Private
export const getChatHistory = asyncHandler(async (req, res) => {
  const history = await ChatMessage.find({ userId: req.user._id })
    .sort({ timestamp: -1 })
    .limit(50);
  res.json(history);
});