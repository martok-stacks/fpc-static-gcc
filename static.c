#include <stdint.h>
#include <stdio.h>

//Import from FreePascal
#ifdef __CPLUSPLUS__
extern "C" {
#endif

extern uint32_t __cdecl GetAnswer();

#ifdef __CPLUSPLUS__
};
#endif

int main( int argc, char** argv ) {
	uint32_t answer;

	answer = GetAnswer();

	printf("%d\n", answer);

	return answer;
}
