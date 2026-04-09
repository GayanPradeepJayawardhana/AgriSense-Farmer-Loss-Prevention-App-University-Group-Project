import asyncHandler from 'express-async-handler';
import Notification from '../models/Notification.js';
import User from '../models/User.js';

// @desc    Create a new notification (Admin or FarmerOfficer)
// @route   POST /api/notifications
// @access  Private/Admin, FarmerOfficer
export const createNotification = asyncHandler(async (req, res) => {
  const { title, body, type, targetUsers, targetRegion, expiresAt } = req.body;

  const notification = await Notification.create({
    title,
    body,
    type,
    targetUsers: targetUsers || [], // if empty, broadcast to all
    targetRegion,
    sentBy: req.user._id,
    expiresAt,
  });

  res.status(201).json(notification);
});

// @desc    Get notifications for current user
// @route   GET /api/notifications
// @access  Private
export const getUserNotifications = asyncHandler(async (req, res) => {
  const user = req.user;
  const now = new Date();

  // Find notifications that target this user or are broadcast (targetUsers empty)
  const notifications = await Notification.find({
    $and: [
      {
        $or: [
          { targetUsers: user._id },
          { targetUsers: { $size: 0 } },
        ],
      },
      {
        $or: [
          { expiresAt: { $exists: false } },
          { expiresAt: { $gt: now } },
        ],
      },
    ],
  })
    .sort({ createdAt: -1 })
    .populate('sentBy', 'name role');

  // Mark as read if not already
  for (const n of notifications) {
    if (!n.readBy.includes(user._id)) {
      n.readBy.push(user._id);
      await n.save();
    }
  }

  res.json(notifications);
});

// @desc    Mark a notification as read/unread
// @route   PATCH /api/notifications/:id/read
// @access  Private
export const markNotificationRead = asyncHandler(async (req, res) => {
  const { read } = req.body; // boolean
  const notification = await Notification.findById(req.params.id);

  if (!notification) {
    res.status(404);
    throw new Error('Notification not found');
  }

  const userId = req.user._id;
  const alreadyRead = notification.readBy.includes(userId);

  if (read && !alreadyRead) {
    notification.readBy.push(userId);
  } else if (!read && alreadyRead) {
    notification.readBy = notification.readBy.filter(id => !id.equals(userId));
  }

  await notification.save();
  res.json({ message: 'Updated' });
});

// @desc    Delete a notification (Admin only)
// @route   DELETE /api/notifications/:id
// @access  Private/Admin
export const deleteNotification = asyncHandler(async (req, res) => {
  const notification = await Notification.findById(req.params.id);
  if (notification) {
    await notification.deleteOne();
    res.json({ message: 'Notification removed' });
  } else {
    res.status(404);
    throw new Error('Notification not found');
  }
});

// @desc    Get all notifications (Admin only)
// @route   GET /api/notifications/all
// @access  Private/Admin
export const getAllNotifications = asyncHandler(async (req, res) => {
  const notifications = await Notification.find({})
    .sort({ createdAt: -1 })
    .populate('sentBy', 'name role');
  res.json(notifications);
});