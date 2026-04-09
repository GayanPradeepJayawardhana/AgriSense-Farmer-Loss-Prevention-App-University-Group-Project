import mongoose from 'mongoose';

const notificationSchema = mongoose.Schema(
  {
    title: { type: String, required: true },
    body: { type: String, required: true },
    type: {
      type: String,
      enum: ['weather', 'pest', 'general', 'reminder'],
      default: 'general',
    },
    targetUsers: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }], // empty = all users
    targetRegion: {
      // optional geographic filter
      lat: Number,
      lng: Number,
      radiusKm: Number,
    },
    sentBy: { type: mongoose.Schema.Types.ObjectId, ref: 'User' },
    readBy: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User' }],
    expiresAt: Date,
  },
  { timestamps: true }
);

const Notification = mongoose.model('Notification', notificationSchema);
export default Notification;