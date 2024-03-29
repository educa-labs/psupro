# Newton service
Este es un micro servicio destinado a proveer de todo lo relacionado a Newton:
 * La predicción de los puntajes de los estudiantes basado en un modelo de regresión 
lineal bayesiana con ajuste a una función de bajo crecimiento (raiz,logaritmo).

 * Sistema recomendador de carreras basado en los puntajes de los usuarios.

El sistema consiste en un paquete de cálculo y una pequeña aplicación flask.

## score-regressor
Paquete python que hace uso de la clase `BayessianRidge` de sklearn. [Docs](https://github.com/educa-labs/tuniversidad-scores-ms/blob/master/score_regressor/README.md)


## newton
Paquete python que contiene el sistema recomendador.

## App flask.

App está en el archivo `main.py`. Posee las siguientes rutas:

* `POST /get_prediction`.

Body:
```json
{
    "days":int_array, 
    "scores":int_array,
    "query_day":int,
    "query_score":int
}
```
Dónde:

* `days` es un arreglo ordenado con los dias relativos (le primera ocurrencia tiene valor 0).
* `scores` es un arreglo de los puntajes obtenidos, donde `scores[i]` es el puntaje de `days[i]`
* `queryday` es el día (relativo) en que se quiere predecir el puntaje (el de la PSU).
* `query_score` puntaje que se desea obtener en `query_day`.
 
Response:
```json
{
    "probability": float,
    "prediction": int,
    "r_score": float
}
```
Dónde:

* `probability` probabilidad de que se obtenga `query_score` en `query_day`.
* `prediction` media estimada de la distribución normal del puntaje en `query_day`
* `r_score` valor R^2 de la regresión. Si el valor es bajo resultado debería ignorarse. (ups)


##Deploy

Para hacer deploy seguir la [guía de don felipe](https://www.guia.educalabs.cl/frameworks/flask.html) y hacer
`pip install -r requirements.txt` en el virtualenv. 

Para actualizar hacer ssh a la máquina, pullear el repo y hacer 
```bash
sudo service tuniversidad-scores-ms restart
``` 
