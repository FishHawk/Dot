import QtQuick 2.12

import Backend 1.0

ShaderEffect {
    property variant src: Backend.dot

    Binding { target: Backend.dot; property: "height"; value: height; delayed: false}
    Binding { target: Backend.dot; property: "width"; value: width; delayed: false }

    vertexShader: "
        uniform highp mat4 qt_Matrix;
        attribute highp vec4 qt_Vertex;
        attribute highp vec2 qt_MultiTexCoord0;
        varying highp vec2 coord;
        void main() {
            coord = qt_MultiTexCoord0;
            gl_Position = qt_Matrix * qt_Vertex;
        }"
    fragmentShader: "
        varying highp vec2 coord;
        uniform sampler2D src;
        uniform lowp float qt_Opacity;
        void main() {
            lowp vec4 tex = texture2D(src, coord);
            gl_FragColor = vec4(tex.rgb * tex.a, tex.a);
        }"
}