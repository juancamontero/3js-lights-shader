//* AMBIENT LIGHT
//? An ambient light applies a uniform light on the surface of the objects, regardless of their orientation. It’s not realistic, but
//? in small doses, it helps lighten up the part of the objects in the shade as if the light was bouncing on walls and getting back to the object.
// vec3 ambientLight(vec3 lightColor, float lightIntensity) {
    //We are returning a vec3 because light can be colored,, light off= 0,0,0
    // return vec3(0.0, 0.0, 0.0);

//? se recibe el color y la intensidad
vec3 ambientLight(vec3 lightColor, float lightIntensity) {

    return lightColor * lightIntensity;
}