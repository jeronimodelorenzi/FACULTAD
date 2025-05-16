/*
Supongamos que tenemos un proceso A que quiere hacerse un pan con manteca. 
La presencia del pan en la mesa se simboliza con una variable booleana P,
e ídem para la manteca con M. Ambas variables están protegidas por un mutex lk.
El proceso A, al haber observado que no había ninguna de las dos cosas,
se puso a esperar la variable de condición cv a que alguien lo despierte cuando ambas
cosas existan sobre la mesa. Si se despierta a A con un solo ingreiente (estado inaceptable),
A destruye la casa en un ataque de furia.
Ahora, el proceso B, habiendo obtenido ambos ingredientes, intenta despertar a A vía la siguiente secuencia:asm

pthread_mutex_lock(&lk);
P = true;
pthread_cond_signal(%cv);
M = true;
pthread_mutex_unlock(&lk);

En este caso el proceso B despierta antes al proceso A de que haya manteca en la mesa, con lo cual el
proceso A destruye toda la casa en un ataque de furia debido a que no hay pan y manteca. 
La solución a este problema podría ser la suguiente:

Thread A:

pthread_mutex_lock(&lk);

while(!(P && M))
  pthread_cond_wait(&cv, &lk);

-P y M son true-

pthread_mutex_unlock(&lk);

Thread B:

pthread_mutex_lock(&lk);
P = true;
M = true;
pthread_cond_signal(%cv);
pthread_mutex_unlock(&lk);
*/