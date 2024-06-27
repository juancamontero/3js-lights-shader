//* POINT LIGHT
//? similar to the directionl
//? comes from a single point 
//? decays with the distance, the far from the light the lower the intensity

vec3 pointLight(vec3 lightColor, float lightIntensity, vec3 normal , vec3 lightPosition, vec3 viewDirection, float specularPower,vec3 position , float lightDecay) {

    //?vector from the position to the light position
    vec3 lightDelta = lightPosition - position;
    

    //? the lightDirection will be a vector goint from the object surface to the ligh position, use the vPosition as 'position'
    vec3 lightDirection = normalize(lightDelta);

    float shading = dot(normal, lightDirection);
 
    shading = max(0.0, shading);

    vec3 lightReflection = reflect(-lightDirection, normal);

    float specular = - dot(lightReflection, viewDirection);
    specular = max(0.0, specular);
    specular= pow(specular, specularPower);

    //* Decay
    //? intensity must decrease with the distance, 

    //? distance from the object position to the light
    float lightDistance = length(lightDelta);

     //? We now want the value to start at 1 when the distance is 0 and to reduce progressively.
     //? the distance and the deacy must be able to twek from the parameters
    float decay = 1.0 - lightDistance * lightDecay;
    decay = max(0.0, decay);
    
    
    // return vec3(decay);
    return lightColor * lightIntensity * decay*( shading + specular);

}