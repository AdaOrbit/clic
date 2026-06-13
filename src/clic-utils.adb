package body CLIC.Utils is
   -------------------------------
   -- Levenshtein_Edit_Distance --
   -------------------------------

   function Levenshtein_Edit_Distance (S, T : String) return Natural is
      D : array (S'First - 1 .. S'Last, T'First - 1 .. T'Last) of Natural;
   begin
      for I in D'Range (1) loop
         D (I, T'First - 1) := I;
      end loop;

      for J in D'Range (2) loop
         D (S'First - 1, J) := J;
      end loop;

      for I in S'Range loop
         for J in T'Range loop
            declare
               Cost : constant Natural :=
                 (if S (I) = T (J)
                  then 0
                  else 1);

               A : constant Natural := D (I - 1, J) + 1;
               B : constant Natural := D (I, J - 1) + 1;
               C : constant Natural := D (I - 1, J - 1) + Cost;
            begin

               D (I, J) := Natural'Min (Natural'Min (A, B), C);
            end;
         end loop;
      end loop;

      return D (D'Last (1), D'Last (2));
   end Levenshtein_Edit_Distance;
end CLIC.Utils;
