import express from 'express';
import {
  createNotification,
  getUserNotifications,
  markNotificationRead,
  deleteNotification,
  getAllNotifications,
} from '../controllers/notificationController.js';
import { protect, authorize } from '../middleware/authMiddleware.js';

const router = express.Router();

router.route('/')
  .post(protect, authorize('Admin', 'FarmerOfficer'), createNotification)
  .get(protect, getUserNotifications);

router.get('/all', protect, authorize('Admin'), getAllNotifications);

router.route('/:id')
  .delete(protect, authorize('Admin'), deleteNotification);

router.patch('/:id/read', protect, markNotificationRead);

export default router;