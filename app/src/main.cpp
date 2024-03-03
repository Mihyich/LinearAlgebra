#include <iostream>

#include "Vector2D.h"
#include "Vector3D.h"
#include "Vector4D.h"

#include "Matrix2D.h"
#include "Matrix3D.h"
#include "Matrix4D.h"

int main(void)
{
    mat4 mat1, mat2;

    mat4_set_rotate_x_degrees(&mat1, 90);
    mat4_set_rotate_axis_degrees(&mat2, 1, 0, 0, 90);

    printf("Test X Axis:\n");
    mat4_output(&mat1);
    printf("------------------------------------------------------\n");
    mat4_output(&mat2);

    mat4_set_rotate_y_degrees(&mat1, 90);
    mat4_set_rotate_axis_degrees(&mat2, 0, 1, 0, 90);

    printf("Test Y Axis:\n");
    mat4_output(&mat1);
    printf("------------------------------------------------------\n");
    mat4_output(&mat2);


    mat4_set_rotate_z_degrees(&mat1, 90);
    mat4_set_rotate_axis_degrees(&mat2, 0, 0, 1, 90);

    printf("Test Z Axis:\n");
    mat4_output(&mat1);
    printf("------------------------------------------------------\n");
    mat4_output(&mat2);


    return 0;
}