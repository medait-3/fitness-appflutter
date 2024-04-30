Stack(
                                  children: [
                                    Positioned.fill(
                                      child: Image.asset(
                                        'assets/glasses/glasses${index + 1}.png',
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                    if (selectedIndex == index)
                                      Positioned(
                                        bottom: 10,
                                        left: 10,
                                        child: Icon(Icons.mail,
                                          color: Colors.black,
                                          size: 25,
                                        ),
                                      ),
                                  ],
                                ),