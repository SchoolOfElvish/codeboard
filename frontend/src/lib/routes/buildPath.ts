export type RouteParams = {
  [key: string]: string | number;
};

export default (route: string) => {
  return (args: RouteParams = {}): string => {
    let output = route;
    const query: { [x: string]: string } = {};

    Object.keys(args).forEach((arg) => {
      const regex = new RegExp(`:${arg}`);
      if (output.includes(arg)) {
        output = output.replace(regex, `${args[arg]}`);
      } else {
        query[arg] = `${args[arg]}`;
      }
    });

    if (Object.keys(query).length) {
      const qs = new URLSearchParams(query);

      return `${output}?${qs.toString()}`;
    }

    return output;
  };
};
