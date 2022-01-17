import { instance } from '@/services/instances.service';

export const getTariffs = async () => {
    try {
        const response = await instance.get('/tariffs');
        return response.data;
    } catch (error) {
        return error.response.data
    }
}

export const updateTariff = async ( uid ) => {
    try {
        const response = await instance.post('/tariff/update', { uid: uid });
        return response.data
    } catch (error) {
        return error.response.data
    }
}
