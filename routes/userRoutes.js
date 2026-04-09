import express from 'express';
import {
  updateUserProfile,
  getAllUsers,
  getUserById,
  updateUserRole,
  deleteUser,
  getFarmersInRegion,
} from '../controllers/userController.js';
import { protect, authorize } from '../middleware/authMiddleware.js';

const router = express.Router();

router.route('/profile')
  .put(protect, updateUserProfile);

router.route('/')
  .get(protect, authorize('Admin'), getAllUsers);

router.route('/farmers/region')
  .get(protect, authorize('Admin', 'FarmerOfficer'), getFarmersInRegion);

router.route('/:id')
  .get(protect, authorize('Admin', 'FarmerOfficer'), getUserById)
  .delete(protect, authorize('Admin'), deleteUser);

router.route('/:id/role')
  .put(protect, authorize('Admin'), updateUserRole);

export default router;