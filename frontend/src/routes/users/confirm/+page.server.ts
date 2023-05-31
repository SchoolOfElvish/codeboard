
import { redirect } from '@sveltejs/kit';
import type { PageServerLoad } from './$types';
import wretch, { type Wretch } from 'wretch';

export const load = (async ({ params, fetch, url} ) => {
    let token = url.searchParams.get("confirmation_token");
    
    // const api = wretch('http://localhost:3000/');
    // const request = api.url('api/v1/confirm_email').post({confirmation_token: token}).json();
    
   const responce = await fetch(`http://backend:3000/api/v1/confirm_email?confirmation_token=${token}` );
  
    console.log(responce);
 
    throw redirect(302, "http://localhost:3001/users/me");
}) satisfies PageServerLoad;


