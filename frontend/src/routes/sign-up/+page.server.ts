import type { Actions } from './$types';


type ResponseData = {
  token: string;
  refresh_token: string;
};

export const actions: Actions = {
  default: async ({ request, cookies, fetch}) => {
    const form = await request.formData();
    const firstName = form.get('first_name');
    const lastName = form.get('last_name');
    const email = form.get('email');
    const password = form.get('password');
    const passwordConfirmation = form.get('password_confirmation');
    const role = form.get('role');
  
    
    const response = await fetch('http://backend:3000/api/v1/sign-up', {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify({ firstName, lastName, email, password, passwordConfirmation, role })
    });

  
    
  
  


    // const response = await result
    //   .error(422, async (error) => {
    //     errors = JSON.parse(error.message).error;
    //     error;
    //   })
    //   .json<ResponseData>();

    // if (response) {
    //   isLoading = false;
    //   if (response.token) {
    //     // user.set({ token: response.token, refreshToken: response.refresh_token });
    //     window.location.href = to.root();
    //   }
    // }
  }
}satisfies Actions;
