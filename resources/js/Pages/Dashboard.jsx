import AuthenticatedLayout from '@/Layouts/AuthenticatedLayout';
import { Head } from '@inertiajs/react';
import PrimaryButton from '@/Components/PrimaryButton';
import axios from 'axios';
import { useForm } from '@inertiajs/react';


export default function Dashboard() {

    const {post} = useForm()

    function sendRequest() {
        // axios.post(import.meta.env.VITE_APP_URL + '/teste', {'teste': 'ok'})

        post(route('dashboard'))
    }



    return (
        <AuthenticatedLayout>
            <Head title="Dashboard-new" />
            <div className="py-12">
                <div className="mx-auto max-w-7xl sm:px-6 lg:px-8">
                
                    <div className="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                        <PrimaryButton
                            onClick={sendRequest}
                        >
                            enviar
                        </PrimaryButton>
                        <div className="p-6 text-gray-900">
                            You're logged in sou foda!
                            
                        </div>
                    </div>

                    <div className="overflow-hidden bg-white shadow-sm sm:rounded-lg">
                        <PrimaryButton
                            onClick={sendRequest}
                        >
                            enviar
                        </PrimaryButton>
                        <div className="p-6 text-gray-900">
                            You're logged in sou foda uhuuu blz ee lklklkl voltou tás!
                            
                        </div>
                    </div>
                </div>
            </div>
        </AuthenticatedLayout>
    );
}
