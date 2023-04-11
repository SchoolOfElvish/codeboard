import { writable } from 'svelte/store';

type NotificationType = 'success' | 'error' | 'info' | 'warning';

type Notificat = {
  message: string;
  description: string;
  type: NotificationType;
};

const createNotification = () => {
  const notifications = writable<Notificat[]>([]);
  const { update, subscribe } = notifications;
  const addNotification = ({ message, description, type }: Notificat) => {
    const newNotification = {
      message,
      description,
      type
    };
    update((notifications) => [...notifications, newNotification]);
  };
  return {
    subscribe,
    success: ({ message, description }: { message: string; description: string }) =>
      addNotification({ message, description, type: 'success' }),
    error: ({ message, description }: { message: string; description: string }) =>
      addNotification({ message, description, type: 'error' }),
    info: ({ message, description }: { message: string; description: string }) =>
      addNotification({ message, description, type: 'info' }),
    warning: ({ message, description }: { message: string; description: string }) =>
      addNotification({ message, description, type: 'warning' })
  };
};

export default createNotification();
