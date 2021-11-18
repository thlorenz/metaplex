import React from 'react';
import { Route, RouteProps } from 'react-router-dom';

export const HashQueryRoute = React.forwardRef<HTMLAnchorElement, RouteProps>(
  function RoutePreservingHashQuery({ path, ...params }) {
    const [_, query] = location.hash.split('?');
    const queryHash = query == null ? '' : `?${query}`;
    return <Route path={`${path}${queryHash}`} {...params} />;
  },
);
