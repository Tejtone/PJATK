#include <iostream>
#include <string>

int main() {
    std::string name;

    std::cout << "Input your name: ";
    std::cin >> name;

    if (name == "Einstein") {
        std::cout << "I know you!" << std::endl;
    } else {
        std::cout << "Greetings." << std::endl;
    }

    return 0;
}
