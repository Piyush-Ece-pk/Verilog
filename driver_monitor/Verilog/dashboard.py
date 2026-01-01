import pygame
import time

pygame.init()
screen = pygame.display.set_mode((600, 400))
pygame.display.set_caption("Driver Monitor Simulator")

clock = pygame.time.Clock()
font = pygame.font.SysFont(None, 30)

accel = 0
steer = 0
brake = 0

f = open("sensor_stream.txt", "w")

running = True
while running:
    for event in pygame.event.get():
        if event.type == pygame.QUIT:
            running = False

    keys = pygame.key.get_pressed()

    accel = 100 if keys[pygame.K_w] else 0
    brake = 100 if keys[pygame.K_SPACE] else 0
    steer = -50 if keys[pygame.K_a] else (50 if keys[pygame.K_d] else 0)

    # Write to file (20 Hz)
    f.write(f"{accel},{steer},{brake}\n")
    f.flush()

    # --------- DRAW UI ----------
    screen.fill((30, 30, 30))

    pygame.draw.rect(screen, (0, 200, 0), (50, 300, accel*2, 20))
    pygame.draw.rect(screen, (200, 0, 0), (50, 330, brake*2, 20))

    steer_x = 300 + steer*2
    pygame.draw.circle(screen, (0, 150, 255), (steer_x, 200), 20)

    screen.blit(font.render("Acceleration", True, (255,255,255)), (50, 270))
    screen.blit(font.render("Brake", True, (255,255,255)), (50, 350))
    screen.blit(font.render("Steering", True, (255,255,255)), (260, 170))

    pygame.display.flip()
    clock.tick(20)

f.close()
pygame.quit()
