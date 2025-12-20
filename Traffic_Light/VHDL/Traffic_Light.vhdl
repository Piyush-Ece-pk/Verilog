library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity traffic_light is
port(
    clk,rst : in std_logic;
    sns,nss,wes,ews : in std_logic;
    n,s,w,e : out std_logic_vector( 1 downto 0)
);
end traffic_light;

architecture behavioral of traffic_light is
type state_t is(
    nr,ny,ng,sr,sy,sg,wr,wy,wg,er,ey,eg
);
signal current_s,next_s : state_t;
signal count : integer ;
signal sig_n,sig_s,sig_w,sig_e : std_logic_vector(1 downto 0);
begin
n <= sig_n;
s <= sig_s;
e <= sig_e;
w <= sig_w;
process(clk,rst)
begin
    if (rst = '0') then
        count <= 0;
        current_s <= nr;
    elsif (rising_edge(clk)) then
        current_s <= next_s;
        if (count = 10) then
            count <= 0;
        else
            count <= count+1;
        end if;
    end if;
end process;

process (current_s,next_s,count,sns,nss,wes,ews)
begin   
    sig_n <= "00";
    sig_s <= "00";
    sig_e <= "00";
    sig_w <= "00";
    case current_s is
        when nr =>
            sig_n <= "10";
            if (sns = '1') then
                next_s <= sg;
            elsif (wes = '1') then
                next_s <= wg;
            elsif (ews = '1') then
                next_s <= eg;
            else 
                next_s <= ng;
            end if;

        when ny => 
            sig_n <= "01";
            if (count = 5) then
                next_s <= ng;
            else 
                next_s <= nr;
            end if;

        when ng =>
            sig_n <= "00";
            if (count = 10) then
                if (nss = '1' and not(sns = '1' or wes = '1' or ews = '1')) then
                    next_s <= ng;
                else 
                    next_s <= ny;
                end if;
            end if;

        when sr =>
            sig_s <= "10";
            if (sns = '1') then
                next_s <= sg;
            elsif (wes = '1') then
                next_s <= wg;
            elsif (ews = '1') then
                next_s <= eg;
            else 
                next_s <= ng;
            end if;

        when sy => 
            sig_s <= "01";
            if (count = 5) then
                next_s <= sg;
            else 
                next_s <= sr;
            end if;

        when sg =>
            sig_s <= "00";
            if (count = 10) then
                if (sns = '1' and not(nss = '1' or wes = '1' or ews = '1')) then
                    next_s <= sg;
                else 
                    next_s <= sy;
                end if;
            end if;
        
        when er =>
            sig_e <= "10";
            if (sns = '1') then
                next_s <= sg;
            elsif (wes = '1') then
                next_s <= wg;
            elsif (ews = '1') then
                next_s <= eg;
            else 
                next_s <= ng;
            end if;

        when ey => 
            sig_e <= "01";
            if (count = 5) then
                next_s <= eg;
            else 
                next_s <= er;
            end if;

        when eg =>
            sig_e <= "00";
            if (count = 10) then
                if (ews = '1' and not(sns = '1' or wes = '1' or nss = '1')) then
                    next_s <= eg;
                else 
                    next_s <= ey;
                end if;
            end if;

        when wr =>
            sig_w <= "10";
            if (sns = '1') then
                next_s <= sg;
            elsif (wes = '1') then
                next_s <= wg;
            elsif (ews = '1') then
                next_s <= eg;
            else 
                next_s <= ng;
            end if;

        when wy => 
            sig_w <= "01";
            if (count = 5) then
                next_s <= wg;
            else 
                next_s <= wr;
            end if;

        when wg =>
            sig_w <= "00";
            if (count = 10) then
                if (wes = '1' and not(sns = '1' or nss = '1' or ews = '1')) then
                    next_s <= wg;
                else 
                    next_s <= wy;
                end if;
            end if;
    end case;
end process;
end behavioral;

