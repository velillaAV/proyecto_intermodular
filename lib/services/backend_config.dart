// Toggle for testing: set to true to use local backend (Android emulator uses 10.0.2.2)
const bool useLocalBackend = false;
const String localBackendUrl = 'http://10.0.2.2:3000';
const String productionBackendUrl = 'https://proyectointermodular-production-9806.up.railway.app';

const String backendBaseUrl = useLocalBackend ? localBackendUrl : productionBackendUrl;
