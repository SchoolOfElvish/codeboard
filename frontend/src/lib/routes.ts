import buildPath from './routes/buildPath';

export type Route = (params?: { [x: string]: string | number }) => string;

export type Routes = {
	root: Route;
	courses: {
		new: Route;
	};
	groups: {
		new: Route;
	};
};

export const to: Routes = {
	root: buildPath('/'),
	courses: {
		new: buildPath('/courses/new')
	},
	groups: {
		new: buildPath('/groups/new')
	}
};
