import buildPath from './routes/buildPath';

export type Route = (params?: { [x: string]: string | number }) => string;

export type Routes = {
  root: Route;
  signUp: Route;
  signIn: Route;
  courses: {
    my: Route;
    new: Route;
  };
  groups: {
    new: Route;
  };
};

export const to: Routes = {
  root: buildPath('/'),
  signUp: buildPath('/sign-up'),
  signIn: buildPath('/sign-in'),
  courses: {
    new: buildPath('/courses/new'),
    my: buildPath('/courses/my')
  },
  groups: {
    new: buildPath('/groups/new')
  }
};
