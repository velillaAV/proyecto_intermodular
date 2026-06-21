require('dotenv').config();
const express = require('express');
const cors = require('cors');
const { createClient } = require('@supabase/supabase-js');

const app = express();
app.use(cors());
app.use(express.json());

const supabase = createClient(process.env.SUPABASE_URL, process.env.SUPABASE_KEY);

// --- RUTAS DE USUARIOS (ApiService) ---

app.post('/api/registerUser', async (req, res) => {
    const { nombre, contrasena, genero, edad, lugarNacimiento } = req.body;
    try {
        const { error: insertError } = await supabase.from('usuarios').insert({
            nombre, contrasena, genero, edad, lugarnacimiento: lugarNacimiento, fotoruta: '', isadmin: false, isblocked: false
        });

        if (insertError) throw insertError;

        const { data, error: selectError } = await supabase
            .from('usuarios')
            .select()
            .eq('nombre', nombre)
            .eq('contrasena', contrasena)
            .single();

        if (selectError) throw selectError;
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.post('/api/login', async (req, res) => {
    const { nombre, contrasena } = req.body;
    try {
        const { data, error } = await supabase
            .from('usuarios')
            .select()
            .eq('nombre', nombre)
            .eq('contrasena', contrasena);

        if (error) throw error;
        if (data.length > 0) {
            res.json(data[0]);
        } else {
            res.status(404).json({ message: "Usuario no encontrado" });
        }
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get('/api/getUsuarios', async (req, res) => {
    try {
        const { data, error } = await supabase.from('usuarios').select();
        if (error) throw error;
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- RUTAS DE JUGADORES (Logicajugadores) ---

app.get('/api/jugadores/posicion/:posicion', async (req, res) => {
    try {
        const { data, error } = await supabase
            .from('jugadores')
            .select()
            .eq('posicion', req.params.posicion);
        if (error) throw error;
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get('/api/jugadores/selecciones/:pais', async (req, res) => {
    try {
        const { data, error } = await supabase
            .from('jugadores')
            .select()
            .eq('pais', req.params.pais);
        if (error) throw error;
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

app.get('/api/jugadores/otorgarEquipo', async (req, res) => {
    try {
        // Obtenemos todos los jugadores por posición para sortearlos en el backend
        const { data: porteros } = await supabase.from('jugadores').select().eq('posicion', 'POR');
        const { data: defensas } = await supabase.from('jugadores').select().eq('posicion', 'DEF');
        const { data: medios } = await supabase.from('jugadores').select().eq('posicion', 'CEN');
        const { data: delanteros } = await supabase.from('jugadores').select().eq('posicion', 'DEL');

        const getRandomUniques = (arr, count) => {
            const shuffled = [...arr].sort(() => 0.5 - Math.random());
            return shuffled.slice(0, count);
        };

        const miPortero = getRandomUniques(porteros, 1);
        const misDefensas = getRandomUniques(defensas, 5);
        const misMedios = getRandomUniques(medios, 4);
        const misDelanteros = getRandomUniques(delanteros, 4);

        const equipoCompleto = [...miPortero, ...misDefensas, ...misMedios, ...misDelanteros];
        res.json(equipoCompleto);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

// --- RUTAS DE PREDICCIONES (Logicapredicciones) ---

app.get('/api/predicciones/:fase', async (req, res) => {
    try {
        const { data, error } = await supabase
            .from('prediccion')
            .select()
            .eq('fase', req.params.fase);
        if (error) throw error;
        res.json(data);
    } catch (error) {
        res.status(500).json({ error: error.message });
    }
});

const PORT = process.env.PORT || 3000;
app.listen(PORT, () => {
    console.log(`Servidor backend corriendo en http://localhost:${PORT}`);
});