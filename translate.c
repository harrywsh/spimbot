#include <stdio.h>
#include <sys/types.h>

int main() {
    unsigned long long order = 0;
    scanf("%lx", &order);
    printf("%lx\n", order);
    unsigned lettuce = order & 0x1f;
    unsigned unchopped_lettuce = (order >> 5) & 0x1f;
    unsigned unwashed_unchopped_lettuce = (order >> 10) & 0x1f;
    unsigned onions = (order >> 15) & 0x1f;
    unsigned unchopped_onions = (order >> 20) & 0x1f;
    unsigned tomatoes = (order >> 25) & 0x1f;
    unsigned unwashed_tomatoes = (order >> 30) & 0x1f;
    unsigned overcooked_meat = (order >> 35) & 0x1f;
    unsigned meat = (order >> 40) & 0x1f;
    unsigned uncooked_meat = (order >> 45) & 0x1f;
    unsigned cheese = (order >> 50) & 0x1f;
    unsigned bread = (order >> 55) & 0x1f;
    unsigned prepadding = (order >> 60) & 0xf;
    printf("prepadding: %zu\n \
            bread: %zu\n \
            cheese: %zu\n \
            uncooked_meat: %zu\n \
            meat: %zu\n \
            overcooked_meat: %zu\n \
            unwashed_tomatoes: %zu\n \
            tomatoes: %zu\n \
            unchopped_onions: %zu\n \
            onions: %zu\n \
            unwashed_unchopped_lettuce: %zu\n \
            unchopped_lettuce %zu\n \
            lettuce: %zu\n", prepadding, bread, cheese, uncooked_meat, meat, overcooked_meat, unwashed_tomatoes, tomatoes, unchopped_onions, 
                             onions, unwashed_unchopped_lettuce, unchopped_lettuce, lettuce);
    return 0;
}