uniform vec3 uColor;

varying vec3 vNormal;
varying vec3 vPosition;


#include ../includes/ambientLight.glsl
#include ../includes/directionalLight.glsl
#include ../includes/pointLight.glsl





void main() {
    vec3 color = uColor;
    // al restar 2 vectores obtengo el angunlo/vector entre los 2
    //! normalize to get a direction, no a position
    vec3 viewDirection = normalize(vPosition - cameraPosition); 

    //? to avoid values differents fromm 1 
    vec3 normal = normalize(vNormal);

    // Lights
    //? light will contain the various light info we are going to calculate, starting with ambientLight(). 
    vec3 light = vec3(0.0);

    //* 1-Ambient light
    // dimmed light
    light += ambientLight(vec3(1.0),  // lightColor
    0.03              // light intensity
    );

    //* 2-Directional light
        light += directionalLight(
        vec3(0.1, 0.1, 1.0), // Light color
        1.0,                 // Light intensity,
        normal,              // Normal
        vec3(0.0, 0.0, 3.0), // Light position
        viewDirection,       // view direction
        20.0                 // specular
    );

    //* 3-Point light
       light += pointLight(
        vec3(1.0, 0.1, 0.1), // Light color
        1.0,                 // Light intensity,
        normal,              // Normal
        vec3(0.0, 2.5, 0.0), // Light position
        viewDirection,       // View direction
        20.0,                 // Specular power
        vPosition,                 // Specular power
        0.25                 // Decay
    );
       light += pointLight(
        vec3(0.1, 1.0, 0.1), // Light color
        1.0,                 // Light intensity,
        normal,              // Normal
        vec3(0.0, -2.5, 0.0), // Light position
        viewDirection,       // View direction
        20.0,                 // Specular power
        vPosition,                 // Specular power
        0.25                 // Decay
    );

    //? Necesitamos combinar el color del objeto con el de la luz
    //? si no hay luz, el color percibido del objeto debe ser negro
    //? Para mezclar los colores y obtener el color percibido se multiplican
    color *= light;

    // Final color
    gl_FragColor = vec4(color, 1.0);
    #include <tonemapping_fragment>
    #include <colorspace_fragment>
}