import { instance } from '@/services/instances.service';

export const getProfile = async () => {
    try {
        const response = await instance.get('/profile');
        return response.data;
    } catch (error) {
        return error.response.data
    }
}
