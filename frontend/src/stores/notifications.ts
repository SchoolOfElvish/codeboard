import { writable } from 'svelte/store';

type NotificationType = 'success' | 'error' | 'info' | 'warning';

export type Notification = {
  message: string;
  description: string | string[];
  type: NotificationType;
};

const createNotification = () => {
  const notifications = writable<Notification[]>([]);
  const { update, subscribe } = notifications;
  const addNotification = ({ message, description, type }: Notification) => {
    const newNotification = {
      message,
      description,
      type
    };
    update((notifications) => [...notifications, newNotification]);
  };
  return {
    subscribe,
    success: ({ message, description }: Omit<Notification, 'type'>) =>
      addNotification({ message, description, type: 'success' }),
    error: ({ message, description }: Omit<Notification, 'type'>) =>
      addNotification({ message, description, type: 'error' }),
    info: ({ message, description }: Omit<Notification, 'type'>) =>
      addNotification({ message, description, type: 'info' }),
    warning: ({ message, description }: Omit<Notification, 'type'>) =>
      addNotification({ message, description, type: 'warning' })
  };
};

export default createNotification();
