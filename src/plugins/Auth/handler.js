export default function AuthHandler (code) {
  switch (code) {
    case 1001:
      return 'Введите свое настоящее имя'
    case 1002:
      return 'Введите свою настоящую фамилию'
    case 1003:
      return 'Введите свою реальную дату рождения, вам должно быть больше 13 лет'
    case 1004:
      return 'Вам должно быть больше 13 лет'
    case 1006:
      return 'Учетная запись с указанным адресом электронной почты не найдена'
    case 1007:
      return 'С этим адресом электронной почты уже есть учетная запись'
    case 1008:
      return 'Указанный адрес электронной почты недействителен'
    case 1009:
      return 'Введите пароль, длина которого превышает 7 символов'
    case 1010:
      return 'Неверный пароль'
  }
}
