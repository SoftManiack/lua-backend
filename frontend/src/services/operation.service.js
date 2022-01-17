import { instance } from '@/services/instances.service';

export const getOperations = async () => {
    try {
        const response = await instance.get('/operation');
        return response.data;
    } catch (error) {
        return error
    }
}

export const operationPay = async ( amount ) => {
    try {
        const response = await instance.post('/operation/pay', { amount: +amount });
        return response.data;
    } catch (error) {
        return error.response.data
    }
}
