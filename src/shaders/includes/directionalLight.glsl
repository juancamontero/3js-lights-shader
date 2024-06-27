//* DIRECTIONAL LIGHT
//? similar a ambientLight, pero la intensidad varía acorde a la orientación del plano/cara y la dirección de la luz

vec3 directionalLight(vec3 lightColor, float lightIntensity, vec3 normal , vec3 lightPosition, vec3 viewDirection, float specularPower) {
    //todo: in vertex shader create normal varying
    //? to get the light direction we must know were the light is comming from, so start for the ligh position
    //? we want the direction. The difference between the two is that the direction is normalized (with a length of 1)
    //! esta al revés va del objetivo a la luz, debería ir al revés
    vec3 lightDirection = normalize(lightPosition);
    
    //todo: add plane to the scene on script
    
    // Shading
    //? si el ángulo de la luz es paralelo al nomral de la cara la intensidad es 100%
    //? si el ángulo de la luz es perpendicular a la normal de la cara, intensidad es 0%
    //? Between interpolated
    //! puedo obtener -1
    //todo: ajustar las normales para que roten con los modelos en el vertex shaders
    float shading = dot(normal, lightDirection);
  
    //* fix the darkness
    //todo: use ambientlight
    //! is black behind , 'cause tge -1 values on shading
    //? to avoid negatives
    shading = max(0.0, shading);

    //* specular - light reflection, light reflecting in the object itself
    //? depends on the view point, the more the reclecting angle is aligned with the view angle, more specular will be
    //? we need the view direction, we hace thue cameraPosition (vec3) uniform available
    //? we also need the fragment position
    //todo: fragment position on vertex shader
    //? finally we need the reflection angle, a reflect function is available
    // vec3 lightReflection = reflect(lightDirection, normal);
    //! la refleccion está invertiada porque la lightDirection va del modelo a la luz, se debe invertir:
    vec3 lightReflection = reflect(-lightDirection, normal);

    //? al comparar la refleccion con el ángulo de vista setermino que tanta luz se refleja
    // float specular = dot(lightReflection, viewDirection);
    //! de esta manera se obtiene -1, porque son angulos opuestos, debemos invertirlo
    float specular = - dot(lightReflection, viewDirection);
    //! en la parte trasera aun se refleja toca limitar el specular
    specular = max(0.0, specular);
    //! aun es muy fuerte, dbemos ajustarlo usando una potencia
    specular= pow(specular, specularPower);
    //! se ve una especie de grilla , esto se causa porque la normal no esta normalizada

    
    // return lightColor * intensity;
    // return vec3(specular);
    // return shading * lightColor * intensity + specular; //get white where should be blue
    // return shading * lightColor * intensity + specular*lightColor; // fixed get white where should be blue
    //! but must depedens of the light intensity
    // return shading * lightColor * lightIntensity + specular*lightColor*lightIntensity; // fixed get white where should be blue
    //? factorizando
    return lightColor * lightIntensity *( shading + specular);

}